require "net/http"
require "formula"
require "language/node"

class Obsidian < Formula
  LATEST_RELEASE = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/obsidian-cr/obsidian/releases/latest")))
  TAG = LATEST_RELEASE["tag_name"]

  version TAG.sub /^v/, ''
  homepage 'https://github.com/obsidian-cr/obsidian'
  head 'https://github.com/obsidian-cr/obsidian.git', branch: 'master'
  url 'https://github.com/obsidian-cr/obsidian.git', using: :git, tag: TAG

  depends_on 'crystal-lang' => :build
  depends_on 'openssl' => :build
  depends_on 'bdw-gc'

  def install
    system 'shards build --release'
    bin.install "bin/obsidian"
  end
end
