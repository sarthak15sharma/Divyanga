reversal =  ['b','q','d','p']
reversal2 = ['o','0']
reversal3 = ['r','y','h']
old_word = input()
word=  input()
for rev in reversal:
    if rev in word:
        for old_rev in reversal:
            if old_rev in old_word and old_rev!=rev:
                print("Reversal Detected.")
                print(f"{old_word} -> {word}")
                print(f"reversal of {old_rev} -> {rev}")

for rev in reversal2:
    if rev in word:
        for old_rev in reversal2:
            if old_rev in old_word and old_rev!=rev:
                print("Reversal Detected.")
                print(f"{old_word} -> {word}")
                print(f"reversal of {old_rev} -> {rev}")

for rev in reversal3:
    if rev in word:
        for old_rev in reversal3:
            if old_rev in old_word and old_rev!=rev:
                print("Reversal Detected.")
                print(f"{old_word} -> {word}")
                print(f"reversal of {old_rev} -> {rev}")