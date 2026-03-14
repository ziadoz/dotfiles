---
name: media-clean-up
description: Clean up downloaded video files in ~/Torrents ready to move to network storage. Use when asked to clean up, organise, or prepare media files.
---

# Media Clean Up

Clean up video files in `~/Torrents` so they are ready to move to network storage.

## Tools

- **FFmpeg** — installed via Brew. Used for container conversion, subtitle extraction, and remuxing.
- **FileBot** — installed via Brew. Used for renaming and organising media files using metadata from online databases.
- **OpenSubtitles** — for sourcing subtitle files when needed.

If a task requires a tool not listed here, ask before proceeding.

## Requirements

Every file must meet all of the following before being considered done:

1. **MP4 container** with a macOS Quick Look preview working.
2. **Placed in a named folder** matching the title of the film or show.
3. **Subtitles included** if the media is not entirely in English, or contains non-English portions. Use forced subtitles for non-English portions within an otherwise English film or show.
4. **Subtitles are clean** — no advertising, no sponsor messages, no audio descriptions (e.g. `[door creaking]`, `[tense music]`).
5. **TV shows are organised into season or series folders** inside the show folder (see naming rules below).

## Folder and File Naming

Use FileBot to rename files. Match against the appropriate database (TheTVDB for TV, TheMovieDB for films).

### Films

```
~/Torrents/
  Film Title (Year)/
    Film Title (Year).mp4
    Film Title (Year).srt   # if required
```

### TV Shows

```
~/Torrents/
  Show Title/
    Series 01/              # UK shows
      Show Title - S01E01 - Episode Title.mp4
    Season 01/              # Everything else
      Show Title - S01E01 - Episode Title.mp4
```

Use `Series` for UK productions, `Season` for everything else. When in doubt about origin, check the show's Wikipedia page or ask.

## Conversion

### MKV to MP4

Use the `mkv2mp4` shell function, which copies all streams without re-encoding and enables fast start for streaming:

```bash
mkv2mp4 "/path/to/folder"
```

This finds all `.mkv` files recursively and remuxes them to `.mp4`. Check the output plays correctly in QuickTime before deleting the source `.mkv`.

### Subtitles embedded in MKV

If the MKV contains subtitle tracks, extract the relevant one before or after conversion:

```bash
# List tracks to find the subtitle track index
ffprobe -v error -show_entries stream=index,codec_type,codec_name:stream_tags=language,title -of default=noprint_wrappers=1 "file.mkv"

# Extract a subtitle track to SRT
ffmpeg -i "file.mkv" -map 0:s:0 "file.srt"
```

Use the forced subtitle track if one exists. If there is no forced track but the film has non-English scenes, extract the full subtitle track and check it manually.

### No macOS preview

If the MP4 does not show a preview in Finder, the video codec is likely not supported natively (e.g. AV1, H.265 with an unsupported profile). Re-encode using the "Convert Video to AV1" Automator workflow, or re-encode with FFmpeg to H.264:

```bash
ffmpeg -i "input.mp4" -c:v libx264 -crf 18 -preset slow -c:a copy -movflags +faststart "output.mp4"
```

## Finding Subtitles

Use OpenSubtitles to find subtitles when none are embedded in the source file, or when a forced subtitle track is needed.

Search at: https://www.opensubtitles.org/en/search/subs

1. Search by film or show title. Filter by language: **English**.
2. For forced subtitles (non-English portions only), filter by type **Forced** if available, or look for entries with "forced" in the release name.
3. Prefer subtitles matched to the exact release (same filename or file size) over generic ones — they will be better synced.
4. Download the `.srt` file and name it to match the video file:
   ```
   Film Title (Year).mp4
   Film Title (Year).en.srt       # full subtitles
   Film Title (Year).en.forced.srt  # forced subtitles only
   ```
5. Spot-check sync by opening in QuickTime and skipping to a dialogue scene. If the timing is off, use FFmpeg to shift the subtitle delay:
   ```bash
   ffmpeg -i "input.srt" -af "adelay=2000|2000" "output.srt"
   ```

## Subtitle Cleaning

After obtaining or extracting subtitles, check for and remove:

- Advertising lines (e.g. `Subtitles by...`, `Sync by...`, `OpenSubtitles.com`, `Downloaded from...`)
- Audio descriptions in square brackets (e.g. `[MUSIC PLAYING]`, `[DOOR SLAMS]`, `[TENSE MUSIC]`)
- Any lines that are not dialogue or essential on-screen text

Edit the `.srt` file directly to remove offending lines. Renumber entries after removing any.

## Workflow

1. Identify all files in `~/Torrents` that are not yet organised.
2. Convert any non-MP4 files to MP4 using `mkv2mp4` or FFmpeg.
3. Verify QuickTime preview works for each file.
4. Rename and organise using FileBot.
5. Add and clean subtitles where required.
6. Confirm all requirements are met before marking as done.
