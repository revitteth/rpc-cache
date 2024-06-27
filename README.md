# RPC Cache

The RPC cache acts as a pass-through for calls to an Ethereum L1. The usecase is syncing L2 nodes which require L1 interaction.

This allows us to unload the L1 nodes, and also speed up the dev process locally by retaining cached values for common queries.

The cache uses boltdb to store response bodies against keys, in a file (default: `./cache.db`).

## Flags

- `-file` - the boltdb cache file 

## Key

The cache key is the `chainId + JSON RPC body` - with the ID stripped out. Where the chainid is the L2 chain id.

## Retention

Additionally, JSON RPC methods can be **excluded**, or have a **cache expiration set**, and the  default behaviour is to **cache indefinitely**.

Response header X-Cache-Status will be set to `HIT` or `MISS` to indicate if the response was served from the cache.

Non-success responses should not be cached, and where possible the cache will evict these if they have historically been cached.

View the code for specifics.

## How to Use
- Start the cache `go run main.go`
- Update the config to use the cache: `zkevm.l1-rpc-url: http://localhost:6969?chainid=2442&endpoint=https%3A%2F%2Frpc.sepolia.org` (replacing endpoint with the original RPC endpoint used)

NB: url encode the RPC node endpoint.