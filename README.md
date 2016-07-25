# jekyll-pants

[![build status](https://img.shields.io/travis/scampersand/jekyll-pants/master.svg?style=plastic)](https://travis-ci.org/agriffis/jekyll-pants?branch=master)
[![gem](https://img.shields.io/gem/v/jekyll-pants.svg?style=plastic)](https://rubygems.org/gems/jekyll-pants)

Jekyll-Pants is a [Jekyll](http://jekyllrb.com/) plugin to convert plain ASCII
punctuation to typographic punctuation HTML entities. It relies on
[RubyPants](https://github.com/jmcnevin/rubypants) which is a Ruby port of the
smart-quotes library SmartyPants.

<table>
<tr><th>Input</th><th>Output</th><th>Rendered</th></tr>
<tr>
<td valign=top><pre>Here's an example--as
you can see...</pre></td>
<td valign=top><pre>Here&amp;#8217;s an example&amp;#8212;as
you can see&amp;#8230;</pre></td>
<td valign=top>Here&#8217;s an example&#8212;as you can see&#8230;</td>
</tr>
</table>


## Rationale

This plugin exists because the default Jekyll support for smart quotes is limited to:

 1. [Markdown](https://daringfireball.net/projects/markdown/) parsed by
    [kramdown](http://kramdown.gettalong.org/) (see note below for how to
    disable kramdown's quoting in favor of jekyll-pants).

 2. The [smartify](https://jekyllrb.com/docs/templates/#filters) filter which is
    actually another way to invoke kramdown's markdown processor, so it doesn't
    work as desired on HTML.

Unlike the built-in solutions, jekyll-pants works on HTML, making it suitable
for applying typographic punctuation to an entire site of hand-authored HTML pages.

## Usage

Add `jekyll-pants` to your site's Gemfile in the `:jekyll-plugins` group and run
`bundle` to install and update Gemfile.lock:

```ruby
group :jekyll_plugins do
  gem "jekyll-pants"
end
```

In your base layout, filter the content through the `pants` filter:

```liquid
<!DOCTYPE html>
<html>
  <head>...</head>
  <body>
    {{content|pants}}
  </body>
</html>
```

Since RubyPants parses HTML tags, this will apply typographic quoting, dashes
and ellipses to text content, but will ignore preformatted text in `<pre>` and `<script>`.

## Em-dashes vs en-dashes

This plugin invokes RubyPants in
["normal" mode](https://github.com/jmcnevin/rubypants/blob/master/lib/rubypants/core.rb#L5),
which means that a double-dash
(`--`) is converted to em-dash (—) and triple-dash (`---`) is ignored,
reflecting the plugin author's preference. This isn't configurable but please
feel free to file a PR if you'd like it to be.

## Working around kramdown

If you'd rather use RubyPants for quoting instead of kramdown, you can add this
to `_config.yml`:

```yaml
kramdown:
  smart_quotes: ["apos", "apos", "quot", "quot"]
```

Unfortunately there's no way to disable kramdown's dashes, which by default
convert `--` to en-dash and `---` to em-dash. However you can use the following
workaround in your invocation to de-convert en-dashes so that jekyll-pants can
handle the conversion.

```liquid
{{content|replace:"–","--"|pants}}
```
