# meh

### meh message format:

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

### Wireshark dissector

Refer [wireshark/README.md](./wireshark/README.md) for installation steps.
