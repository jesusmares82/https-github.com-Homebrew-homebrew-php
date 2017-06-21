require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yaml < AbstractPhp72Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0.tgz"
  sha256 "ef13ff56c184290c025a522bf9ae2e1b3ecc8543c3a5161dd02adec90897a221"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
