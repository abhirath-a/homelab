
{
  flake.nixosModules.searxng =
    { config, ... }:
    let
      # Inherit maintained upstream engine definitions.
      #
      # General engines that are unreliable remain available
      # for manual selection, but not default searches.
      generalEngines = [
        {
          name = "google";
          shortcut = "go";
          disabled = false;
          timeout = 10.0;
        }
        {
          name = "mojeek";
          shortcut = "mjk";
          disabled = false;
          timeout = 10.0;
        }
        {
          name = "brave";
          shortcut = "br";
          disabled = true;
          timeout = 10.0;
        }
        {
          name = "duckduckgo";
          shortcut = "ddg";
          disabled = true;
          timeout = 10.0;
        }
        {
          name = "startpage";
          shortcut = "sp";
          disabled = true;
          timeout = 10.0;
        }
        {
          name = "marginalia";
          shortcut = "mar";
          disabled = true;
        }
      ];

      # Specialized engines should not run during
      # ordinary general searches.
      #
      # Disabled engines remain selectable manually.
      specializedEngines = [
        {
          name = "wikipedia";
          shortcut = "wp";
          categories = [ "general" ];
          disabled = true;
        }
        {
          name = "wikidata";
          shortcut = "wd";
          categories = [ "general" ];
          disabled = true;
          weight = 2;
        }
        {
          name = "openlibrary";
          shortcut = "ol";
          disabled = true;
        }
        {
          name = "internet archive";
          shortcut = "ia";
          disabled = true;
        }

        # Scientific research
        {
          name = "arxiv";
          shortcut = "arx";
          categories = [ "science" ];
          disabled = false;
        }
        {
          name = "astrophysics data system";
          shortcut = "ads";
          categories = [ "science" ];
          disabled = true;
        }
        {
          name = "pubmed";
          shortcut = "pub";
          categories = [ "science" ];
          disabled = false;
        }
        {
          name = "europe pmc";
          shortcut = "epmc";
          categories = [ "science" ];
          disabled = true;
        }
        {
          name = "semantic scholar";
          shortcut = "se";
          categories = [ "science" ];
          disabled = false;
        }
        {
          name = "openalex";
          shortcut = "oa";
          categories = [ "science" ];
          disabled = false;
        }
        {
          name = "crossref";
          shortcut = "cr";
          categories = [ "science" ];
          disabled = true;
        }
        {
          name = "inspirehep";
          shortcut = "insp";
          categories = [ "science" ];
          disabled = true;
        }
        {
          name = "oeis";
          shortcut = "oeis";
          categories = [ "science" ];
          disabled = true;
        }

        # Development
        {
          name = "github";
          shortcut = "gh";
          categories = [ "it" ];
          disabled = false;
        }
        {
          name = "github code";
          shortcut = "ghc";
          categories = [ "it" ];
          disabled = true;
        }
        {
          name = "arch linux wiki";
          shortcut = "al";
          categories = [ "it" ];
          disabled = false;
        }
        {
          name = "grep.app";
          shortcut = "grep";
          categories = [ "it" ];
          disabled = true;
        }
        {
          name = "devdocs";
          shortcut = "dev";
          categories = [ "it" ];
          disabled = true;
        }
        {
          name = "huggingface";
          shortcut = "hf";
          categories = [ "it" "science" ];
          disabled = true;
        }
        {
          name = "lobste.rs";
          shortcut = "lo";
          categories = [ "it" ];
          disabled = true;
        }
        {
          name = "hackernews";
          shortcut = "hn";
          categories = [ "it" ];
          disabled = true;
        }
      ];

      # These require additional configuration or use
      # specialized implementations.
      customEngines = [
        {
          name = "math stackexchange";
          engine = "stackexchange";
          shortcut = "math";
          api_site = "math";
          categories = [ "science" "q&a" ];
          disabled = true;
        }
        {
          name = "stackoverflow";
          engine = "stackexchange";
          shortcut = "st";
          api_site = "stackoverflow";
          categories = [ "it" "q&a" ];
          disabled = false;
        }
        {
          name = "mdn";
          engine = "json_engine";
          shortcut = "mdn";
          categories = [ "it" ];
          disabled = true;

          paging = true;
          search_url =
            "https://developer.mozilla.org/api/v1/search?q={query}&page={pageno}";
          results_query = "documents";
          url_query = "mdn_url";
          url_prefix = "https://developer.mozilla.org";
          title_query = "title";
          content_query = "summary";
        }
        {
          name = "nixos wiki";
          engine = "mediawiki";
          shortcut = "nixw";
          categories = [ "it" ];
          disabled = false;

          base_url = "https://wiki.nixos.org/";
          search_type = "text";
        }
        {
          name = "huggingface datasets";
          engine = "huggingface";
          shortcut = "hfd";
          huggingface_endpoint = "datasets";
          categories = [ "it" "science" ];
          disabled = true;
        }
        {
          name = "huggingface spaces";
          engine = "huggingface";
          shortcut = "hfs";
          huggingface_endpoint = "spaces";
          categories = [ "it" ];
          disabled = true;
        }
      ];
    in
    {
      services.searx = {
        enable = true;

        environmentFile =
          config.sops.templates."searxng-env".path;

        settings = {
          use_default_settings = true;

          general = {
            debug = false;
            instance_name = "Search";

            privacypolicy_url = false;
            donation_url = false;
            contact_url = false;

            enable_metrics = false;
          };

          search = {
            safe_search = 0;

            # Avoid extra upstream requests while typing.
            autocomplete = "";
            autocomplete_min = 4;

            default_lang = "auto";

            # HTML for humans, JSON for agents.
            formats = [
              "html"
              "json"
            ];
          };

          server = {
            port = 8888;
            bind_address = "127.0.0.1";

            secret_key = "@SEARXNG_SECRET@";

            # Suitable only when access is restricted
            # to trusted clients.
            limiter = false;
            public_instance = false;

            method = "GET";
            image_proxy = false;

            default_http_headers = {
              X-Content-Type-Options = "nosniff";
              X-Download-Options = "noopen";
              X-Robots-Tag = "noindex, nofollow";
              Referrer-Policy = "no-referrer";
            };
          };

          ui = {
            default_theme = "simple";
            center_alignment = false;
            query_in_title = false;

            theme_args = {
              simple_style = "auto";
            };

            search_on_category_select = true;
            hotkeys = "default";
            url_formatting = "pretty";
          };

          outgoing = {
            request_timeout = 8.0;
            max_request_timeout = 15.0;

            useragent_suffix = "";

            pool_connections = 100;
            pool_maxsize = 20;

            enable_http2 = true;
          };

          plugins = {
            "searx.plugins.calculator.SXNGPlugin".active = true;
            "searx.plugins.infinite_scroll.SXNGPlugin".active = false;
            "searx.plugins.hash_plugin.SXNGPlugin".active = true;
            "searx.plugins.self_info.SXNGPlugin".active = true;
            "searx.plugins.unit_converter.SXNGPlugin".active = true;
            "searx.plugins.ahmia_filter.SXNGPlugin".active = true;
            "searx.plugins.hostnames.SXNGPlugin".active = true;
            "searx.plugins.time_zone.SXNGPlugin".active = true;
            "searx.plugins.tracker_url_remover.SXNGPlugin".active = true;
          };

          categories_as_tabs = {
            general = { };
            images = { };
            it = { };
            science = { };
          };

          engines =
            generalEngines
            ++ specializedEngines
            ++ customEngines;
        };
      };
    };
}
