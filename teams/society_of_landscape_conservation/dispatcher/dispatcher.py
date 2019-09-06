from neo4j import GraphDatabase

class HelloWorldExample(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self._driver.close()

    def print_greeting(self, message):
        with self._driver.session() as session:
            greeting = session.write_transaction(self._create_and_return_greeting, message)
            print(greeting)

    @staticmethod
    def _create_and_return_greeting(tx, message):
        result = tx.run("MATCH (a:Application) \
                        WHERE a.name = $message\
                        RETURN a \
                        LIMIT 25",
                        message=message)
        return result.single()[0]

def main():
  hello = HelloWorldExample("bolt://rpzlwpr007.pez.roche.com:7687", 'neo4j', "i890o098")
  hello.print_greeting("ARCS")
 
if __name__== "__main__":
  main()