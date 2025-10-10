# 🧭 SourceGit Cheat Sheet — for smooth brains & sane people

A quick guide for using **SourceGit**, the open-source GitHub Desktop alternative.  
Follow this and you’ll avoid 90% of merge explosions.

---

## 🧱 1. Basic Git Flow

Every time you open SourceGit:

Pull → Edit → Stage → Commit → Push

That’s the loop. Do it in that order and you’re good.

---

## 🔄 2. Updating Before You Work
**Button:** 🔽 **Pull**  
> Grabs the newest changes from GitHub.  
> Always do this *before* editing files.

---

## ✏️ 3. After You Make Edits
**Stage your changes:**  
- Check the file list on the left.  
- Tick the box next to files you’ve edited.  
  - ✅ means “include this file in the next commit.”

**Then click:**  
🧩 **Commit**  
- Add a short message like:  
  `added footstep sfx task` or `fixed art note`
- Click the **Commit** button.

---

## ☁️ 4. Sending Your Changes Online
**Button:** ☁️ **Push**  
> Uploads your commits to GitHub so others get them.  
> Only click *after* committing!

---

## 📥 5. Getting Everyone Else’s Updates
**Button:** 🔽 **Pull** again.  
> Syncs your local copy with new changes from others.  
> If someone else pushed stuff, this brings it to your machine.

---

## 🌿 6. Branches (optional for jams)
- Think of branches as “alternate timelines.”  
- You can click **Branch → New Branch** to make one for experiments.  
- When done, **Merge** it back into `main`.  
*(For short jams, you can just work on `main`.)*

---

## ⚔️ 7. Merge Conflicts (when Git freaks out)
If you and someone edit the *same lines* in a file:
- SourceGit will show a red ⚠️ “conflict” marker.
- Open the file, decide which version to keep.
- Mark it as resolved (SourceGit has a “Resolve” button).
- Commit again.

If it’s just checkboxes or Markdown changes, don’t panic — usually easy fixes.

---

## 🗂️ 8. Visual Map (Commit Graph)
Middle panel shows your timeline of commits:
- **Circles** = commits  
- **Lines** = branches merging  
- Hover or click a commit to see what changed.

---

## 📋 9. Quick Reference Buttons

| Icon / Menu      | What it does              | Use it when                               |
| ---------------- | ------------------------- | ----------------------------------------- |
| 🔽 **Pull**      | Get new stuff from GitHub | Before editing                            |
| 🧩 **Commit**    | Save your work locally    | After staging changes                     |
| ☁️ **Push**      | Upload commits            | After committing                          |
| 🪄 **Fetch**     | Check for remote updates  | Sometimes before pulling                  |
| 🌿 **Branch**    | Make or switch branches   | If doing experimental work                |
| ⚔️ **Merge**     | Combine branches          | When merging feature branches             |
| 💬 **Stash**     | Temporarily save changes  | When you need to switch branches mid-edit |
| 🔍 **Diff View** | Shows what changed        | Always check before committing            |

---

## 🧠 10. Safe Habits
- Always **Pull before Push.**
- Keep **commit messages short and clear.**
- Don’t rename or delete files unless you mean it.
- Commit small chunks instead of massive all-in-one changes.
- If something looks wrong, **don’t panic—Pull again and check the diff.**

---

## 🎯 TL;DR Summary
| Step | Action | What It Does |
|------|---------|--------------|
| 1️⃣ | **Pull** | Update your local copy |
| 2️⃣ | **Edit Files** | Do your jam work |
| 3️⃣ | **Stage + Commit** | Save your progress |
| 4️⃣ | **Push** | Send it to GitHub |
| 5️⃣ | **Pull again later** | Keep synced |

---

## ⚡ Pro Tips for Jams
- Only one person edits `Tasks.md` layout — others just tick boxes.  
- Don’t open the same `.canvas` file as someone else simultaneously.  
- If something breaks, right-click the last good commit → **Revert** (SourceGit will undo that commit for you).

---

**Boom.** You’re now SourceGit-certified and 85% less likely to cry during merge conflicts.
