var user = db.system.users.find({'user':'propostanova'});
if(!user.length()) {
    admin = db.getSiblingDB('admin');
    admin.createUser({ user: 'propostanova', pwd: 'propostanova', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });
    print("Usuário foi criado com sucesso.");
}