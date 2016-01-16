import graphene


class User(graphene.Interface):
    roles = graphene.String()
    name = graphene.String()

    def resolve_roles(self, args, info):
        return self.roles

    def resolve_name(self, args, info):
        return self.name


class Subscriber(User):

    def resolve_roles(self, args, info):
        return "[\"sub\"]"


class Admin(User):

    def resolve_roles(self, args, info):
        return "[\"admin\"]"


schema = graphene.Schema(query=Subscriber)

result = schema.execute('{ roles }')
print result.data['roles']
