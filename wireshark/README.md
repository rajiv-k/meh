# Installing the custom dissector in Wireshark

To install the custom Lua dissector plugin:
1. Clone the repository

    ```sh
    $ git clone https://github.com/rajiv-k/meh.git
    ```

2. Locate the plugins directory where Wireshark looks for custom dissectors.

    The location of the plugins directory varies depending on your OS.
    Go to `Help > About Wireshark` (on Windows) or `Wireshark > About Wireshark` on macOS and select the `Folders` tab.
    Double click the `Personal Lua Plugins` to open this folder.

3. Copy the `./wireshark/meh.lua` plugin into the Plugin directory
4. Restart Wireshark
5. Enable the custom dissector

    `macOS`: Go to `Analyze` > `Enabled Protocols`
