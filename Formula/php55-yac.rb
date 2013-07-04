require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Yac < AbstractPhp55Extension
  init
  homepage 'https://github.com/laruence/yac'
  url 'https://github.com/laruence/yac.git', :branch => 'master'
  head 'https://github.com/laruence/yac.git'
  version 'latest'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w(modules/yac.so)
    write_config_file unless build.include? "without-config-file"
  end
end
