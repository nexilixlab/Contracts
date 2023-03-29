const HDWalletProvider = require("@truffle/hdwallet-provider");
var privateKey =
  "xxxxxxxx";
var publicKey = "0x36f1F2BCeEf708a533cdC2d0Ddb8A10bB2Cdf045";

module.exports = {
  plugins: ["truffle-flydax-verify"],

  networks: {
    testnet: {
      host: "10.42.50.8", // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      provider: function () {
        return new HDWalletProvider(
          privateKey, // private keys array
          "http://10.42.50.8:8545" // URL to an Ethereum node
        );
      },
      blockscoutUrl: "http://10.42.50.8:8545",
      from: publicKey,
      network_id: 4242,
      chain_id: 4242,
    },

    mainnet: {
      host: "10.42.50.8", // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      provider: function () {
        return new HDWalletProvider(
          privateKey, // private keys array
          "http://10.42.50.8:8545" // URL to an Ethereum node
        );
      },
      blockscoutUrl: "http://10.42.50.8:8545",
      from: publicKey,
      network_id: 4242,
      chain_id: 4242,
    },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.12",      // Fetch exact version from solc-bin
      settings: {
        optimizer: {
          enabled: false,
          //runs: 10000000   // Optimize for how many times you intend to run the code
        }
      }
    },
  },

  // Truffle DB is currently disabled by default; to enable it, change enabled:
  // false to enabled: true. The default storage location can also be
  // overridden by specifying the adapter settings, as shown in the commented code below.
  //
  // NOTE: It is not possible to migrate your contracts to truffle DB and you should
  // make a backup of your artifacts to a safe location before enabling this feature.
  //
  // After you backed up your artifacts you can utilize db by running migrate as follows:
  // $ truffle migrate --reset --compile-all
  //
  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "indexeddb",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};
