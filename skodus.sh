#!/usr/bin/python


import getpass,sys
from sqlite3 import dbapi2 as database

kodi_path = "/Users/"+getpass.getuser()+"/Library/Application Support/Kodi"
no_filter = True if len(sys.argv) == 1 else False

db = database.connect(kodi_path+
    "/userdata/addon_data/plugin.video.exodus/providers.13.db").cursor()

last_imdb_id_q = "SELECT imdb_id FROM rel_src ORDER BY added DESC LIMIT 1"
last_season_q  = "SELECT season  FROM rel_src ORDER BY added DESC LIMIT 1"
last_episode_q = "SELECT episode FROM rel_src ORDER BY added DESC LIMIT 1"

query = """
SELECT * FROM rel_src WHERE
imdb_id = (%s) AND
season  = (%s) AND
episode = (%s);
""" % (last_imdb_id_q, last_season_q, last_episode_q)

sources_from_db = []
for row in db.execute(query):
    source_dict = eval(row[4])
    for i in source_dict:
        if no_filter or i['source'] in sys.argv[1:]:
            sources_from_db.append(i)

for i in sources_from_db:
    print i['source'] + " - " + i['quality'] + " - " + i['url']
