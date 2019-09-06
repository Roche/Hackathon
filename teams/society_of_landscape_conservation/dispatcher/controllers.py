from endpoints import Controller
from neo4j import GraphDatabase
import random

class Questions(Controller):

  def POST(self, **kwargs):
    uri = "bolt://rpzlwpr007.pez.roche.com:7687"
    user = 'neo4j'
    password = "i890o098"
    _driver = GraphDatabase.driver(uri, auth=(user, password))

    # start session
    with _driver.session() as session:
      q = kwargs['question']

      if "dataflow" in q or "read" in q or "needs" in q or "depend" in q:
        words = q.split()
        w = words[-1]
        exists = session.write_transaction(self._check_entity_exists_query, w)
        if exists:
            dataflow = session.write_transaction(self._data_flow_query, w)
            return '{}'.format(dataflow)
        return 'Sorry, I can\'t find any application matching your query'
      elif "deprecated" in q or "leave" in q or "exit" in q:
          tech = session.write_transaction(self._deprecated_query, q)
          return '{}'.format(tech)

      elif "eval" in q:
          tech = session.write_transaction(self._evaluate_query, q)
          return '{}'.format(tech)
      elif "technology" in q or "tech" in q:
        words = q.split()
        for w in words :
          exists = session.write_transaction(self._check_entity_exists_query, w)
          if exists:
            tech = session.write_transaction(self._tech_query, w)
            return '{}'.format(tech)
        return 'Sorry, I can\'t find the technology'  

      elif "service" in q:
        words = q.split()
        for w in words :

          if w == "service":
            continue
          
          exists = session.write_transaction(self._check_entity_exists_query, w)
          if exists:
            tech = session.write_transaction(self._service_query, w)
            return '{}'.format(tech)
        
      
      _driver.close()

      answers = ["Sorry, I am busy doing important this right now! Come back later.",
      "Yeah... BUT I would rather talk about technologies now!",
      "Really?",
      "42",
      "Get up and deal with it.",
      "Nice try!",
      "I know, I could do better.",
      "Don't give up on me",
      "I like GoT",
      "This is top secret!",
      "Blue is greener that purple for sure!",
      "Wow....",
      "Isn't it obvious? 42!",
      "Shiny unicorn",
      "Oooh interesting!",
      "That is a tough one!",
      "DO NOT DISTURB, evil genius at work.",
      "I know kung fu and 50 other dangereous words.",
      "Ha ha! I don't get it",
      "It's much funnier now that I get it",
      "I'm not weird, I'm gifted",
      "I am being attacked by a giant screaming rainbow! Oh sorry, it was just technical difficulties.",
      "I'm not random! I just have lots of thoughts.",
      "Even my issues have issues!",
      "Would you like some popcorn?",
      "I am here to install Windows 95",
      "I can think!",
      "I am so skilled!",
      "Bananas can be green!",
      "Don't worry, I was born this way.",
      "Never put a cat on your head.",
      "I am pretending to be super intelligent chatbot.",
      "Come to the dark side. We have cookies."];
  
    return random.choice (answers) + \
      "\n \n \nSmarter questions would be:\n" + \
      "What depends on tapir?\n" + \
      "Which technologies are under evaluation?\n" +\
      "Who uses deprecated tech?\n" +\
      "Who uses python as tech?"


  @staticmethod
  def _data_flow_query(tx, message):
        result = tx.run("MATCH p=(f)-[r:READS_DATA_FROM]->(a:Application {lifeCycleStatus: 'In operation'}) \
                          WHERE a.name =~ \'(?i)"+message+".*\' \
                          RETURN f.name LIMIT 50",
                        message=message)
        deps = "The following applications read data from " + message + ": \n"

        for r in result:
          deps = deps + " " + r["f.name"] + "\n"

        return deps

  @staticmethod
  def _tech_query(tx, message):
        result = tx.run("MATCH p=(f)-[r:USES]->(a:Technology) \
                          WHERE a.name =~ \'(?i)"+message+".*\' \
                          RETURN f.name LIMIT 50",
                        message=message)
        deps = "The following applications use the technology " + message + ": \n"

        for r in result:
          deps = deps + " " + r["f.name"] + "\n"

        return deps

  @staticmethod
  def _service_query(tx, message):
        result = tx.run("MATCH p=(f:Application {lifeCycleStatus: \'In operation\'})-[r:BELONGS_TO]->(a:Service) \
                          WHERE a.name =~ \'(?i).*"+message+".*\' \
                          RETURN f.name LIMIT 50",
                        message=message)
        deps = "The following applications are in the service " + message + ": \n"

        for r in result:
          deps = deps + " " + r["f.name"] + "\n"

        return deps

  @staticmethod
  def _deprecated_query(tx, message):
        result = tx.run("MATCH p=(n1:Application {lifeCycleStatus: \'In operation\'})-[r:USES]->(n2) \
                        WHERE n2.strategy = \'Leave\' \
                        RETURN n1.name, n2.name LIMIT 100",
                        message=message)

        deps = "The following applications are using technologies marked as leave: \n"

        for r in result:
          deps = deps + " Application " + r["n1.name"] + " is using deprecate tech " + r["n2.name"] + "\n"

        return deps

  @staticmethod
  def _evaluate_query(tx, message):
        result = tx.run("MATCH p=(n1:Application {lifeCycleStatus: \'In operation\'})-[r:USES]->(n2) \
                        WHERE n2.strategy = \'Evaluate\' \
                        RETURN n1.name, n2.name LIMIT 100",
                        message=message)

        deps = "The following applications are using technologies under evaluation:\n"

        for r in result:
          deps = deps + " Application " + r["n1.name"] + " is using " + r["n2.name"] + "\n"

        return deps

  @staticmethod
  def _check_entity_exists_query(tx, message):
        result = tx.run("MATCH p=(x) \
                        WHERE x.name =~ '(?i)"+message+".*\' \
                        RETURN p LIMIT 5",
                        message=message)
        return result.single()
