Meteor.startup(function () {
  if (Meteor.users.find().count() < 1) {
    Accounts.createUser({
      username: 'kadira',
      email: 'kadira@kadira.com',
      password: 'kadira',
      profile: {
        name: 'Kadira Admin'
      }
    });
  }
});
