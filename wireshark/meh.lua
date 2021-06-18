meh_protocol = Proto("Meh",  "Meh Protocol")

--[[

meh message format:
-------------------

        0         4         8                16
        +---------+---------+----------------+
        |d|  ver  | flags   |    opcode      |
        +---------+--------------------------+
        |                length              |
        +------------------------------------+
        |                                    |
        .            ...  body ...           .
        .                                    .
        +-------------------------------------

    d (1 bit): direction of message
               1: client to server
               0: server to client

    ver(3 bit): protocol version
    flags(4 bit)
    opcode(1 byte)
    length(2 bytes): length of message payload following the header
    body (variable): message payload
--]]

local t_direction = {
    [0] = "ServerToClient",
    [1] = "ClientToServer"
}

local t_opcode = {
    [0] = "Invalid",
    [1] = "Handshake",
}

message_direction = ProtoField.uint8("meh.direction", "Direction", base.DEC, t_direction, 0x80)
message_version = ProtoField.uint8("meh.version", "Version", base.DEC, NULL, 0x70)
message_flags = ProtoField.uint8("meh.flags", "Flags", base.DEC, NULL, 0x0F)
message_opcode = ProtoField.uint8("meh.opcode", "Opcode", base.DEC, t_opcode)
message_length = ProtoField.uint16("meh.length", "Length", base.DEC)

meh_protocol.fields = {message_direction, message_version, message_flags, message_opcode, message_length}

function meh_protocol.dissector(buffer, pinfo, tree)
  length = buffer:len()
  if length == 0 then return end

  pinfo.cols.protocol = meh_protocol.name

  local subtree = tree:add(meh_protocol, buffer(), "Meh Protocol Data")
  subtree:add(message_direction, buffer(0, 1))
  subtree:add(message_version, buffer(0, 1))
  subtree:add(message_flags, buffer(0, 1))
  subtree:add(message_opcode, buffer(1, 1))
  subtree:add(message_length, buffer(2, 2))
end

local tcp_port = DissectorTable.get("tcp.port")
tcp_port:add(6666, meh_protocol)

