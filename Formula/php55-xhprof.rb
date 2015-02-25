require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xhprof < AbstractPhp55Extension
  init
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/archive/254eb24dcfa763c76c57b472093ebc4b81af2b7d.tar.gz'
  sha1 'bab248d9a44a99515f96eb086bfa9d8932874451'
  head 'https://github.com/facebook/xhprof.git'
  version '254eb24'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "2bdd02714f35b1a4ea1270ec17344245de5d9d56" => :yosemite
    sha1 "343f6bd9c0514c4b190d132b7e70afc6de003059" => :mavericks
    sha1 "682e3e600b6df4aa06c413a2b1c5e11282c0c657" => :mountain_lion
  end

  depends_on 'pcre'

  def install
    Dir.chdir "extension" do
      ENV.universal_binary if build.universal?

      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install "modules/xhprof.so"
    end

    prefix.install %w(xhprof_html xhprof_lib)
    write_config_file if build.with? "config-file"
  end
end
