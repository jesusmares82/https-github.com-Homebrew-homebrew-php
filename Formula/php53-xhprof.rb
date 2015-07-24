require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xhprof < AbstractPhp53Extension
  init
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/archive/254eb24dcfa763c76c57b472093ebc4b81af2b7d.tar.gz'
  sha1 'bab248d9a44a99515f96eb086bfa9d8932874451'
  head 'https://github.com/facebook/xhprof.git'
  version '254eb24'

  bottle do
    sha1 "47708a788ee2a9dd10eb9c8e835b65260013ad74" => :yosemite
    sha1 "7d7431062b4e4e080cb6ef975036072ea253424a" => :mavericks
    sha1 "cf22f7ab122ee83db2e8cc2752c71a09423c6858" => :mountain_lion
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
