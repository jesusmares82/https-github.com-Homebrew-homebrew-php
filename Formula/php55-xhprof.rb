require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Xhprof < AbstractPhp55Extension
  init
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/tarball/254eb24dcfa763c76c57b472093ebc4b81af2b7d'
  sha1 '601e6f02776ef9a1292de2e3e75e644a7114689a'
  head 'https://github.com/facebook/xhprof.git'
  version '254eb24'

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
    write_config_file unless build.include? "without-config-file"
  end
end
