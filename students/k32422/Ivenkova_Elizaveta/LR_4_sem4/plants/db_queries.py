def get_owner_and_plant_name(cursor, user_plant_id):
    cursor.execute('select user_id, plant_id from user_plant where user_plant_id=%s',
                   [user_plant_id])
    user_id, plant_id = cursor.fetchone()

    cursor.execute('select user_name, user_surname from plantuser where user_id=%s',
                   [user_id])
    name, surname = cursor.fetchone()

    cursor.execute('select plant_name from plant where plant_id=%s',
                   [plant_id])
    plant_name = cursor.fetchone()[0]
    return name, surname, plant_name

