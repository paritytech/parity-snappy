##PARITY on Ubuntu Core
------
**[ethcore.io](https://ethcore.io)**
Parity is a cross-platform open-source Ethereum client (RUST implementation).
Once installed, you will get parity-daemon running in your device. You can interact with it through the web UI, accessible at *http://<your-ip-or-host>:8080/* user - parity pass parity or via JSON-RPC at *http://<your-ip-or-host>:8545/*
You can update settings in the *parity* file in the */writable/system-data/apps/parity/current/* directory. 
Note: The daemon should be stopped before making changes, otherwise settings will be applied on next reboot.
To start/stop/check status (service is automatically started on install/boot):

    $ sudo service parity_parity_1.1.0 [start|stop|status]

#### Useful links
* [WIKI](https://github.com/ethcore/parity-snappy/wiki)
* [JSON-RPC Protocol Spec](https://ethereumbuilders.gitbooks.io/guide/content/en/ethereum_json_rpc.html)
* [License GPL v3 ](http://www.gnu.org/licenses/gpl-3.0.en.html)
