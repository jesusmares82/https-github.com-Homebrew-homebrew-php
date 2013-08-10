require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Midgard2 < AbstractPhp54Extension
  init
  homepage 'http://www.midgard-project.org'
  url 'https://github.com/midgardproject/midgard-php5.git', :tag => '12.09.1'
  head 'https://github.com/midgardproject/midgard-php5.git', :branch => 'ratatoskr'

  depends_on 'pkg-config' => :build
  depends_on 'midgard2'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file unless build.include? "without-config-file"
  end
end
