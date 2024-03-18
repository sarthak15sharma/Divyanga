from transformers import pipeline
import re
import nltk
from nltk import edit_distance
from nltk.corpus import words
import difflib


def spell_check(s1):
    # Load the spelling correction pipeline
    fix_spelling = pipeline("text2text-generation",
                            model="oliverguhr/spelling-correction-english-base")

    input_words = s1.split() # to check each word
    corrections = fix_spelling(s1, max_length=2048) # Using transformer

    # output as array
    corrected_words = re.findall(r'\b\w+\b', corrections[0]['generated_text'])  # Corrected Output

    print(corrected_words)
    print(input_words)
    incorrect_words = []
    count = 0
    for i in range(len(corrected_words)):
        if corrected_words[i].lower() != input_words[i].lower():
            count += 1
            incorrect_words.append(input_words[i])

    print("Incorrect Words: ",incorrect_words)
    total_words = len(corrected_words)
    error_percentage = (count / total_words) * 100 if total_words != 0 else 0  # error percentage

    print(error_percentage, " % error detected")

    # Convert both lists to lowercase
    corrected_words_lower = [word.lower() for word in corrected_words]
    input_words_lower = [word.lower() for word in input_words]

    # Find words from corrected_words that are different from input_words
    different_words = [
        word for word in corrected_words if word.lower() not in input_words_lower]
    print("Words which were originally wrong:" ,different_words)

    # nltk.download('words')
    english_words = words.words('en')

    # Filter words based on length
    filtered_words = [word for word in english_words if len(
        word) in {len(w) for w in different_words}]

    # Use difflib for initial efficient suggestions within filtered words
    similar_words_difflib = []
    for word in different_words:
        similar_words_difflib.extend(difflib.get_close_matches(
            word, filtered_words, n=10, cutoff=0.7))

    # Calculate additional suggestions using edit distance
    for word in different_words:
        max_distance = 0  # Adjust threshold as needed
        additional_words = [
            w for w in filtered_words if edit_distance(word, w) <= max_distance]
        similar_words_difflib.extend(additional_words[:min(
            10 - len(similar_words_difflib), len(additional_words))])
    similar_words_difflib = list(set(similar_words_difflib))
    
    print("Similar words for", different_words, ":", similar_words_difflib)

    # Reversals
    reversal =  ['b','q','d','p']
    reversal2 = ['o','0']
    reversal3 = ['r','y','h']
    reversals = []
    for i in range(len(incorrect_words)):
        old_word = incorrect_words[i]
        word = different_words[i]
        for rev in reversal:
            if rev in word:
                for old_rev in reversal:
                    if old_rev in old_word and old_rev!=rev:
                        print("Reversal Detected.")
                        print(f"{old_word} -> {word}")
                        print(f"reversal of {old_rev} -> {rev}")
                        reversals.append((old_rev,rev))

        for rev in reversal2:
            if rev in word:
                for old_rev in reversal2:
                    if old_rev in old_word and old_rev!=rev:
                        print("Reversal Detected.")
                        print(f"{old_word} -> {word}")
                        print(f"reversal of {old_rev} -> {rev}")
                        reversals.append((old_rev,rev))

        for rev in reversal3:
            if rev in word:
                for old_rev in reversal3:
                    if old_rev in old_word and old_rev!=rev:
                        print("Reversal Detected.")
                        print(f"{old_word} -> {word}")
                        print(f"reversal of {old_rev} -> {rev}")
                        reversals.append((old_rev,rev))



spell_check("he is adle ot walk")