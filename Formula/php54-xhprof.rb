require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xhprof < AbstractPhp54Extension
  init
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/archive/254eb24dcfa763c76c57b472093ebc4b81af2b7d.tar.gz'
  sha1 'bab248d9a44a99515f96eb086bfa9d8932874451'
  head 'https://github.com/facebook/xhprof.git'
  version '254eb24'

  bottle do
    sha1 "61d745f801e920032ddb60f6435930f3b98b00a4" => :yosemite
    sha1 "95353e32a80594275f71bd952d633299cb893fc5" => :mavericks
    sha1 "166aaa596955aac2396947942f4f1b3bd0857c0c" => :mountain_lion
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
