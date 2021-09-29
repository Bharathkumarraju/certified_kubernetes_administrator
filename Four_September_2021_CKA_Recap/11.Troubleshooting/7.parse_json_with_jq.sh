MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test.json | jq .[0]
"hi"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test.json | jq .[]
"hi"
"hello"
"test"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test.json | jq .[0,1,2]
"hi"
"hello"
"test"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test.json | jq .[0,2]
"hi"
"test"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


---------------------------------------------------------------------------------------------------------->

MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test2.json | jq .vehicles
{
  "car": {
    "color": "blue",
    "price": "$20,000"
  },
  "bus": {
    "color": "white",
    "price": "$120,000"
  }
}
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test2.json | jq .vehicles.car
{
  "color": "blue",
  "price": "$20,000"
}
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test2.json | jq .vehicles.car.price
"$20,000"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ cat test2.json | jq .vehicles.bus.price
"$120,000"
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


