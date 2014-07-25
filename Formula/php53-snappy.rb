require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Snappy < AbstractPhp53Extension
  init
  homepage 'https://github.com/kjdev/php-ext-snappy'
  url 'https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz'
  sha1 'd41dcb066d2d6b495d883d9e0089f6b22f143107'
  version '0.1.0'

  depends_on 'snappy'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/snappy.so"
    write_config_file if build.with? "config-file"
  end
end
