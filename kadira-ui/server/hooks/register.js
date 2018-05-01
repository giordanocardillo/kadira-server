Meteor.startup(function () {
  if (Meteor.users.find().count() < 1) {
    let userId = Accounts.createUser({
      username: 'kadira',
      email: 'kadira@kadira.com',
      password: 'kadira',
      profile: {
        name: 'Kadira Admin'
      }
    });

    Meteor.users.update({ _id: userId }, { $set: { plan: 'business' } });
  }
});
