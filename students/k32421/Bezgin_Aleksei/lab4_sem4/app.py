import sqlite3

import streamlit as st

from utils import is_email_valid

# Connect to database
conn = sqlite3.connect("matching_app.db")
c = conn.cursor()

# Create table if it doesn't exist
c.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)")


def create_user(name, email):
    # Insert a new user into the database
    c.execute("INSERT INTO users (name, email) VALUES (?, ?)", (name, email))
    conn.commit()


def read_user(id):
    # Select a user from the database by id
    c.execute("SELECT * FROM users WHERE id=?", (id,))
    return c.fetchone()


def update_user(id, name, email):
    # Update a user in the database by id
    c.execute("UPDATE users SET name=?, email=? WHERE id=?", (name, email, id))
    conn.commit()


def delete_user(id):
    # Delete a user from the database by id
    c.execute("DELETE FROM users WHERE id=?", (id,))
    conn.commit()


# Define Streamlit app
def app():
    # Title
    st.title("Users' information menu")

    # Sidebar menu
    menu = ["New User", "Find User", "Change User", "Drop User"]
    choice = st.sidebar.selectbox("Select an operation", menu)

    # Create User
    if choice == "New User":
        st.header("New User")

        name = st.text_input("Name")
        email = st.text_input("Email")

        if st.button("Create"):
            if len(name) > 0 and len(email) > 0:
                if is_email_valid(email):
                    create_user(name, email)
                    st.success("User created!")
                else:
                    st.warning("Invalid email")
            else:
                st.warning("Fill both name and email.")


    # Read User
    elif choice == "Find User":
        st.header("Find User")

        id = st.number_input("ID", min_value=1)

        if st.button("Read"):
            user = read_user(id)

            if user:
                st.write("Name:", user[1])
                st.write("Email:", user[2])
            else:
                st.warning("User not found.")

    # Update User
    elif choice == "Change User":
        st.header("Change User")

        id = st.number_input("ID", min_value=1)
        name = st.text_input("Name")
        email = st.text_input("Email")

        if st.button("Update"):
            if len(name) > 0 and len(email) > 0:
                if is_email_valid(email):
                    user = read_user(id)

                    if user:
                        update_user(id, name, email)
                        st.success("User updated!")
                    else:
                        st.warning("User not found.")
                else:
                    st.warning("Invalid email")
            else:
                st.warning("Fill both fields. If field is not supposed to be changed, write the origin value")

    # Delete User
    elif choice == "Drop User":
        st.header("Drop User")

        id = st.number_input("ID", min_value=1)

        if st.button("Drop"):
            user = read_user(id)

            if user:
                delete_user(id)
                st.success("User deleted!")
            else:
                st.warning("User not found.")

    # Close database connection
    c.close()
    conn.close()


if __name__ == "__main__":
    app()
