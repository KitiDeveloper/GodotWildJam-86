# 📜 Game Jam Vault — Rules & Guides

Welcome to the project vault!  
This folder holds **everything** related to the jam — notes, tasks, GDD, and any extra planning.  
Keep it tidy and it’ll love you back ❤️

---
## 🧱 Folder Structure (Flat & Simple)
Everything lives in the main area for this jam:
- `GDD.md` → full game design doc  [[Game Design Document]]
- `Tasks.md` → to-do / progress board  [[Task Board]]
- `Registry.md` → list of participants & roles  [[Jammer Registry]]
- `Rules & Guides.md` → you’re reading it  [[Rules & Guides]]
- `SorceGit Guide.md` → How to use SourceGit [[SorceGit Guide]]
- any other notes (mechanics, art ideas, test builds) go here too  

---
## 🧍 Etiquette & Workflow Rules
1. **Pull before you edit.**  
   Always get the latest version before changing stuff (avoids Git merge pain).
2. **Commit clearly.**  
   Use short commit messages like `added footstep sfx task` or `updated GDD art section`.
3. **Don’t delete or rename main notes.**  
   (`Tasks.md`, `GDD.md`, `Registry.md`, and `Rules_and_Guides.md` stay as is.)
4. **Only the lead (Kiti)** edits the main task list layout.  
   You can tick boxes but don’t move or reorder things unless told.
5. **New ideas?**  
   Make a new note: `idea_featureName.md` or `idea_artStyle.md`. Keeps history clean.
6. **Keep notes lightweight.**  
   Don’t dump huge raw files or logs here; link to them if needed.
7. **Respect the clock.**  
   It’s a jam — small, consistent updates beat one giant last-minute push.

---
## 🧠 Tags & Priorities

Use tags for sorting:

`#audio  #art  #code  #ui  #design`

Add priority keywords:

- 🔺 **High** — must be done for submission
- 🟡 **Medium** — good polish / nice-to-have
- 🔵 **Low** — optional, do if time allows

Example task:

`- [ ] Add jump SFX 🔺 **High** #Audio`

`- [x] Add jump SFX @Ginger`

---
## 🧩 Collaboration Tips

- One main `Tasks.md`, everyone else uses their own notes if needed.

- Obsidian auto-saves — no manual “Save” button.

- If two people edit the same box line, Git might conflict; don’t panic, just re-tick the right one and recommit.

---
## 🐛 If Things Break

- Don’t panic.
    
- Pull again.
    
- Check Git logs for what changed.
    
- Ask Kiti before deleting or overwriting files.
    
- Always keep your local copy backed up before major edits.

---
## 🧾 Formatting Cheat sheet
Obsidian uses **Markdown**.  
Here’s a quick crash course:

`# Big Title`
`## Section Title`
`### Small Header`

`- [ ] Unticked box`
`- [x] ticked box`

`**BOLD TEXT**`
`_italic text_`

`> Quote block good for notes / comments`

```
This is a code block thingy
```
