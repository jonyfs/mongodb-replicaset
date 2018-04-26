function randomString(size) {
    var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var randomstring = "";
    var string_length = size;
    for (var i = 0; i < string_length; i++) {
        var rnum = Math.floor(Math.random() * chars.length);
        randomstring += chars.substring(rnum, rnum + 1);
    }
    return randomstring;
}

function addDays(date, days) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

db.createCollection("contacts", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["phone", "name", "email", "birthDate", "status"],
            properties: {
                phone: {
                    bsonType: "int",
                    minimum: 0,
                    description: "must be a int greather than 0"
                },
                name: {
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                email: {
                    bsonType: "string",
                    description: "must be a string, ends with @test.com and is required"
                },
                birthDate: {
                    bsonType: "date",
                    description: "must be a date and is required"
                },
                status: {
                    enum: ["Active", "Inactive"],
                    description: "can only be one of the enum values and is required"
                }
            }
        }
    }
});

var name;
for (var i = 0; i < 20000; i++) {
    contact_name =
        randomString(6) + " " + randomString(8) + " " + randomString(10);
    db.contacts.save({
        phone: Math.round(Math.random() * 15),
        name: contact_name,
        email: contact_name.replace(/\s/g, ".") + "@test.com",
        birthDate: addDays(new Date(), -Math.round(Math.random() * 10000)),
        status: i % 5 == 0 ? "Active" : "Inactive"
    });
}