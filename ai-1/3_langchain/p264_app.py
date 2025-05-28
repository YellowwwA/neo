import os
from langchain.agents import load_tools
from langchain.chat_models import ChatOpenAI
from langchain.chains.conversation.memory import ConversationBufferMemory
from langchain.agents import initialize_agent

google_cse_id = os.environ.get("WOLFRAM_ALPHA_APPID")

tools = load_tools(['wolfram-alpha'])

memory = ConversationBufferMemory(
    memory_key = "chat_history",
    return_messages = True,
)

agent = initialize_agent(
    agent = "zero-shot-react-description",
    llm = ChatOpenAI(
        model = "gpt-3.5-turbo",
        temperature = 0
    ),
    tools = tools,
    memory = memory,
    verbose = True,
)

query = "How many kilometers is the distance between LA and GrandCanyon?"
print('-'*50)
print(query)
print(agent.run(query))