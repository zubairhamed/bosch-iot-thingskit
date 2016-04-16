# Bosch IoT Things library for Swift
Swift Library for using Bosch IoT Things

For Java integration, find examples @ https://github.com/bsinno/cr-examples

## Usage

See ThingsKitTest.swift

```
var tk = ThingsKit(user: "User", password: "password", token: "secretToken")

var thing = Thing()
thing.attributes["model"] = "MDL100"
thing.attributes["serial"] = "sZX83o1293919K"

tk.creatThing(thing, completion: {
	(created, result) in

	if result.isSuccess() {
		print(created.thingId)
	}	
})
```