# encoding: utf-8

require 'spec_helper'

describe(Jekyll::PantsFilter) do
  let(:overrides) do
    {
      "source"      => source_dir,
      "destination" => dest_dir,
      "url"         => "http://example.org",
    }
  end
  let(:config) { Jekyll.configuration(overrides) }
  let(:site) { Jekyll::Site.new(config) }
  before(:each) { site.process }
  let(:html_output) { File.read(dest_dir("html/with-pants.html")) }
  let(:markdown_output) { File.read(dest_dir("markdown/with-pants.html")) }

  it "makes HTML pretty" do
    expect(html_output).to match /#{Regexp.quote "Makin&#8217; it purty&#8212;don&#8217;t you think?"}/
    expect(html_output).to_not match /Makin'|purty--don|don't/
  end

  it "preserves HTML pre" do
    expect(html_output).to match /#{Regexp.quote "But not this! This shouldn't be pretty--because it's code."}/
    expect(html_output).to_not match /shouldn\&#8217;t|pretty\&#8212;because/
  end

  it "preserves kramdown smart quotes" do
    expect(markdown_output).to match /#{Regexp.quote "Makin’ it purty–don’t you think?"}/
    expect(markdown_output).to_not match /Makin'|purty--don|don't/
  end

  it "preserves code in markdown" do
    expect(markdown_output).to match /#{Regexp.quote "But not this! This shouldn't be pretty--because it's code."}/
    expect(markdown_output).to_not match /shouldn\&#8217;t|pretty\&#8212;because/
  end

  context "without kramdown smart quotes" do
    let(:config) do
      dumb_kramdown = {"kramdown" => {"smart_quotes" => ["apos", "apos", "quot", "quot"]}}
      Jekyll.configuration(Jekyll::Utils.deep_merge_hashes(overrides, dumb_kramdown))
    end

    # There's no way to prevent kramdown from replacing dashes, so this ends up
    # being a mix of kramdown dashes (UTF-8) and rubypants entities.
    it "makes markdown pretty" do
      expect(markdown_output).to match /#{Regexp.quote "Makin&#8217; it purty–don&#8217;t you think?"}/
      expect(markdown_output).to_not match /Makin'|purty--don|don't/
    end
  end

  context "without pants" do
    let(:html_output) { File.read(dest_dir("html/without-pants.html")) }
    let(:markdown_output) { File.read(dest_dir("markdown/without-pants.html")) }

    it "leaves HTML alone" do
      expect(html_output).to match /#{Regexp.quote "It ain't purty--without pants."}/
      expect(html_output).to_not match /\&/  # no entities
    end

    it "leaves HTML pre alone" do
      expect(html_output).to match /#{Regexp.quote "Nor this--it ain't no better."}/
      expect(html_output).to_not match /\&/  # no entities
    end

    it "leaves kramdown smart quotes alone" do
      expect(markdown_output).to match /#{Regexp.quote "It ain’t purty–without pants."}/
      expect(markdown_output).to_not match /ain't purty|purty--without/
    end
  end

end
