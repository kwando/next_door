import gleeunit
import gleeunit/should
import next_door.{ArpEntry}

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  next_door.arp_table()
  |> should.be_ok
  |> should.not_equal([])
}

pub fn parse_test() {
  "? (10.0.0.1) at 94:a6:7e:7a:d3:17 on en0 ifscope [ethernet]
  ? (10.0.0.3) at 0:17:88:62:da:92 on en0 ifscope [ethernet]
  ? (10.0.0.4) at 70:31:7f:84:dc:8b on en0 ifscope [ethernet]
  ? (10.0.0.5) at fe:10:32:1:1d:f4 on en0 ifscope [ethernet]
  ? (10.0.0.7) at dc:a6:32:77:e7:3f on en0 ifscope [ethernet]
  ? (10.0.0.10) at 12:b3:ee:4:1b:9d on en0 ifscope [ethernet]
  ? (10.0.0.11) at f4:34:f0:36:1e:8b on en0 ifscope [ethernet]
  ? (10.0.0.24) at 7a:e4:d1:aa:3f:92 on en0 ifscope [ethernet]
  ? (10.8.0.4) at (incomplete) on en0 ifscope [ethernet]
  ? (224.0.0.251) at 1:0:5e:0:0:fb on en0 ifscope permanent [ethernet]
  ? (239.255.255.250) at 1:0:5e:7f:ff:fa on en0 ifscope permanent [ethernet]
  ? (239.255.255.250) at 1:0:5e:7f:ff:fa on bridge100 ifscope permanent [ethernet]
  ? (239.255.255.250) at 1:0:5e:7f:ff:fa on bridge101 ifscope permanent [ethernet]"
  |> next_door.parse_table
  |> should.be_ok
  |> should.equal([
    ArpEntry("10.0.0.1", "94:a6:7e:7a:d3:17", "en0"),
    ArpEntry("10.0.0.3", "0:17:88:62:da:92", "en0"),
    ArpEntry("10.0.0.4", "70:31:7f:84:dc:8b", "en0"),
    ArpEntry("10.0.0.5", "fe:10:32:1:1d:f4", "en0"),
    ArpEntry("10.0.0.7", "dc:a6:32:77:e7:3f", "en0"),
    ArpEntry("10.0.0.10", "12:b3:ee:4:1b:9d", "en0"),
    ArpEntry("10.0.0.11", "f4:34:f0:36:1e:8b", "en0"),
    ArpEntry("10.0.0.24", "7a:e4:d1:aa:3f:92", "en0"),
    ArpEntry("10.8.0.4", "(incomplete)", "en0"),
    ArpEntry("224.0.0.251", "1:0:5e:0:0:fb", "en0"),
    ArpEntry("239.255.255.250", "1:0:5e:7f:ff:fa", "en0"),
    ArpEntry("239.255.255.250", "1:0:5e:7f:ff:fa", "bridge100"),
    ArpEntry("239.255.255.250", "1:0:5e:7f:ff:fa", "bridge101"),
  ])
}

pub fn mac_to_ip_test() {
  let table = [
    ArpEntry("10.0.0.1", "94:a6:7e:7a:d3:17", "en0"),
    ArpEntry("10.0.0.3", "0:17:88:62:da:92", "en0"),
    ArpEntry("10.0.0.4", "70:31:7f:84:dc:8b", "en0"),
    ArpEntry("10.0.0.5", "fe:10:32:1:1d:f4", "en0"),
  ]

  next_door.mac_to_ip(table, "70:31:7f:84:dc:8b")
  |> should.be_ok
  |> should.equal("10.0.0.4")

  next_door.mac_to_ip(table, "70:31:7F:84:DC:8B")
  |> should.be_ok
  |> should.equal("10.0.0.4")

  next_door.mac_to_ip(table, "aa:aa:aa:aa:aa:aa")
  |> should.equal(Error(Nil))
}
