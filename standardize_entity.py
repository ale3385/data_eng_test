import openai

# Configure OpenAI API key
OPENAI_API_KEY = "sk-ZeXvbp_nBQ4n851rUQ29XJAVsG2M9QokBa3TJtOUljT3BlbkFJ0sZawUMOIj3aVsgqXKQC6qm91IhiYB7SdS6eCAHqkA"

client = openai.OpenAI(api_key=OPENAI_API_KEY)

def standardize_entity(entity_text, entity_type):
    """
    Uses GPT-3.5 to standardize an entity such as diseases or medications.

    Parameters:
        entity_text (str): The text of the entity you want to standardize.
        entity_type (str): The type of entity, for example, 'disease' or 'medication'.

    Returns:
        str: The standardized entity.
    """
    prompt = f"Standardize the following {entity_type}: {entity_text}. Provide the standardized name."

    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are an expert in medical data standardization."},
            {"role": "user", "content": prompt}
        ]
    )

    standardized_name = response.choices[0].message.content.strip()
    return standardized_name

# Example usage
entity_text = "inflamation of liver"
entity_type = "disease"
standardized_name = standardize_entity(entity_text, entity_type)
print(f"Standardized Name: {standardized_name}")