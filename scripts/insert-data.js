function randomString(size) {
    var chars =
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var randomstring = '';
    var string_length = size;
    for (var i = 0; i < string_length; i++) {
        var rnum = Math.floor(Math.random() * chars.length);
        randomstring += chars.substring(rnum, rnum + 1);
    }
    return randomstring;
}

db.createCollection("contacts",
    {
        validator: {
            $or:
                [
                    { phone: { $type: "long" } },
                    { name: { $type: "string" } },
                    { email: { $regex: /@test\.com$/ } },
                    { birthDate: { $type: "date" } },
                    { status: { $in: ["Active", "Inactive"] } }
                ]
        }
    });

var name
for (var i = 0; i < 20000; i++) {
    contact_name = randomString(6) + randomString(8) + randomString(10);
    db.test.save(
        {            
            phone: Math.floor(Math.random() * 15),
            name: contact_name,
            email: contact_name + '@test.com',
            birthDate: Math.floor(Math.random() * 10000),
            status: (i % 2 == 0?'Active':Inactive)
        }
    );
} 