var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "mongodb1:27017",
                "priority": 2
            },
            {
                "_id": 2,
                "host": "mongodb2:27017",
                "priority": 0
            },
            {
                "_id": 3,
                "host": "mongodb3:27017",
                "priority": 0
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.addArb("mongodbarbiter:27017");
    rs.reconfig(cfg, { force: true });
