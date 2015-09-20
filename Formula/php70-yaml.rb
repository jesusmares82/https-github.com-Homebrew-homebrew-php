require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaml < AbstractPhp70Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
