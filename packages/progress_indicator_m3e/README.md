
# progress_indicator_m3e (spec build)

**Visual rules implemented**
- Active and track never overlap.
- Circular ring is *broken* around the active sweep.
- Squiggle variants (48/52) draw a sine-like stroke inside the ring with 2dp clearance.
- Linear shows two lanes (active above, track below) with fixed gap and end-dot, per table.

**Linear variants**
- `flatXS` — track 4, gap 4, dot Ø4, dotOffset 4, trailing 4
- `flatS`  — track 8, gap 4, dot Ø4, dotOffset 2, trailing 8
- `wavyM`  — track 4, wave amp 3, period 40, gap 4, dot Ø4, dotOffset 2, trailing 10
- `wavyL`  — track 8, wave amp 3, period 40, gap 4, dot Ø4, dotOffset 2, trailing 14


---

## Live demo (Gallery)

Explore this component in the M3E Gallery (GitHub Pages):

https://<your-github-username>.github.io/material_3_expressive/

To run the Gallery locally:

```sh
cd apps/gallery
flutter run -d chrome
```

_Last updated: 2025-10-23_
