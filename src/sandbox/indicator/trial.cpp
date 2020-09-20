#include "trial.hpp"

#include <indicators/progress_bar.hpp>

namespace sandbox {
namespace indicator {

void Do() {
    using namespace indicators;
    ProgressBar bar{option::BarWidth{50},
                    option::Start{"["},
                    option::Fill{"="},
                    option::Lead{">"},
                    option::Remainder{" "},
                    option::End{"]"},
                    option::PostfixText{"Extracting Archive"},
                    option::ForegroundColor{Color::green},
                    option::FontStyles{std::vector<FontStyle>{FontStyle::bold}}};

    while (!bar.is_completed()) {
        bar.tick();
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

}  // namespace indicator
}  // namespace sandbox
