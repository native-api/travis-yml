# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Bintray < Deploy
            register :bintray

            def define
              super
              map :file,       to: :str
              map :user,       to: :secure
              map :key,        to: :secure
              map :passphrase, to: :secure
              map :dry_run,    to: :bool

              export
            end
          end
        end
      end
    end
  end
end