# next_door

Find IP for mac addresses.
[![Package Version](https://img.shields.io/hexpm/v/next_door)](https://hex.pm/packages/next_door)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/next_door/)

```sh
gleam add next_door@1
```
```gleam
import next_door

pub fn main() -> Nil {
  next_door.arp_table()
  |> next_door.mac_to_ip("aa:aa:aa:aa:aa:aa")
}
```

Further documentation can be found at <https://hexdocs.pm/next_door>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
