# Information for contribution/development

## Notes on how colors are used

**This is a draft** which might not paint the whole picture right now. 

### Introduction

The main intent of this section is to help contributors decide on how to use
colors and looks when making contribution.

In a simplified sense it's might be beneficial to imagine the light theme as
being as close as possible to writing written text on paper with a few tools
like markers and coloured pencils at hand to highlight **exceptional
circumstances**.

This is not meant to be a strict guide but it can probably be followed in most
situations.

### Upstream Solarized palette usage documentation

The base Solarized colors have a canonical
[usage documentation](http://ethanschoonover.com/solarized#usage-development)

When referring to colors, the convention is to use the dark theme's
base color names directly, e.g. `(:foreground ,base0)`. They will switch to
their counterparts automatically in the light theme.

Usage table for the automatic dark/light base colors:

* `,base1` - optional emphasized content
* `,base0` - body text / default code / primary content
* `,base00` - unspecified (it's a separator)
* `,base01` - comments / secondary content
* `,base02` - background highlights
* `,base03` - background

### Basic strategy for selecting colors

The most important general rule is to **avoid color pasta**.

Examples:

- Try to start by not using accent colors at all. It's common to get a good
  enough visual separation by just using the baseXX colors.
- Avoid having several accent colors grouped in a small space
- Avoid having accent colors that are cycled or striped repeatedly.
- It's sometimes even preferable to hide information by reusing colors rather
  than creating more visual noise. It's hard to decide (for other people) what
  to simplify/reduce away but it leads to a better reading experience.
- For things small spaces like indicators, the baseXX are usually enough. The
  indicator symbols themselves are probably good enough carriers of
  information.

### Accent colors that are used in special ways

(Draft note: This is a simplified list written i haste, needs much more
details. In worst case scenario it's even wrong, probably not though. Some of
the bullet points lacks explanation right now)

Generally I try to only use the most basic colors which I guess is
cyan/blue/green/yellow (again, if possible).

Some specific color information:

- **magenta** is used as a temporary highlight color, in most cases it matches
  direct user input actions such as isearch matches, ...
- **red** is used to indicate errors only.
  - Exception: In buffers displaying only or mostly a diff, **red** is ok for
    indicating "removed".
- **orange** is used to indicate errors only but be a little more relaxed with
  that rule as opposed to **red**.
- **violet** is very rarely used at all
- **blue** / **green** / **red** can be used for diff like things indicating
  modified/added/removed

### Using colors that are not in the original solarized theme

(TODO: document the lc/hc colors and possibly some of the blending that's used at places)

- If possible, just don't do it.
- One common usage is when there is a need to add yet another overlay where
  most regular colors already are in use.
- the lc/hc colors should usually be used together as fg/bg or bg/fg since
  their contrast relationships works best like that.




