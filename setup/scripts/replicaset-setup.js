var cfg = {
    "_id": "rs0",
    "version": 1,
    "members": [{
            "_id": 0,
            "host": "mongodb1:27017",
            "priority": 1
        },
        {
            "_id": 2,
            "host": "mongodb2:27017",
            "priority": 0.5
        },
        {
            "_id": 3,
            "host": "mongodb3:27017",
            "priority": 0.5
        }
    ]
};
rs.initiate(cfg, { force: true });
rs.reconfig(cfg, { force: true });