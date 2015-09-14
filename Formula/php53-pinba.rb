require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pinba < AbstractPhp53Extension
  init
  homepage 'http://pinba.org/'
  url 'https://github.com/tony2001/pinba_extension/archive/6869f30e8c264e7a5742ab55f4f6bd5ee29e6080.tar.gz'
  sha1 '15d1fb5e339d1dec6bfe80e94414de6299d4df86'
  head 'https://github.com/tony2001/pinba_extension.git'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w(modules/pinba.so)

    write_config_file if build.with? "config-file"
  end
end
