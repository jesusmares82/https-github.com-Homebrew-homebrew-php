require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libvirt < AbstractPhp53Extension
  init
  homepage 'http://libvirt.org/php'
  url 'http://libvirt.org/sources/php/libvirt-php-0.4.8.tar.gz'
  sha1 '933c20e70f83107d056528b8c665a024da9bc7a4'

  depends_on 'pkg-config' => :build
  depends_on 'libvirt'

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install 'src/libvirt-php.so' => 'libvirt.so'
    write_config_file if build.with? "config-file"
  end
end
