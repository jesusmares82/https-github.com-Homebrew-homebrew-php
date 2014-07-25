require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Midgard2 < AbstractPhp55Extension
  init
  homepage 'http://www.midgard-project.org'
  url 'https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz'
  sha1 'd83519a9d513a47e9e6a02e90f6fb957f036b082'
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
    write_config_file if build.with? "config-file"
  end
end
