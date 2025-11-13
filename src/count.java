public class count {
    String str =
"""
        Literature Review
        Web Automation Tools
        
        Browser automation has evolved from simple scripting to sophisticated frameworks capable of cross-browser, language-agnostic, and heavily parallel workflows. Traditional tools such as Selenium WebDriver long dominated the space, enabling programmatic control of browsers via WebDriver protocols (e.g., Shastri et al. 2022 on WhatsApp automation using Selenium).\s
        IJARIIT
         Recent comparative studies show that newer frameworks like Playwright, Puppeteer and Cypress provide higher performance, reduced flakiness and better cross-browser support. For instance, García et al. (2024) provide a systematic analysis of Selenium, Cypress, Puppeteer and Playwright, noting Playwright’s superior concurrency and robustness.\s
        SpringerLink
        +1
         These findings underpin our decision to build from scratch using Playwright rather than relying on legacy Selenium automation.
        
        Messaging Platforms & WhatsApp
        
        Instant messaging platforms present unique automation challenges due to real-time UI updates, asynchronous message flows, and complex anti-automation detection. Research such as “Automated Chat Application Surveys Using WhatsApp” (Fei & Wolff, 2020) illustrates automation over WhatsApp for surveys, though not addressing detection-resilience.\s
        jointdatacenter.org
         Industry analyses show WhatsApp automation (via Business APIs or SDKs) improves engagement and retention: for example, business automation approaches report open rates as high as 98%.\s
        Gallabox
        +1
         Despite this, many solutions use unofficial libraries, risking policy violations. Our work focuses explicitly on a compliant automation stack for WhatsApp, aligning with official channels or delegate-session flows, rather than circumventing protections.
        
        Custom Integration Libraries & Toolchains
        
        While off-the-shelf libraries exist, many maintainers struggle with detection-hardening, fingerprinting resistance, and orchestration across large volumes of chats. Our proposed library—Tweakio‑WhatsApp (to be published)—is built atop Playwright and offers modular scripting, fingerprint rotation, event-level human-motion emulation, and a prioritized compliance layer. This fills a gap: previous literature seldom reports full tool-chain design (automation engine, AI integration, state persistence) in one reusable package. Notably, research such as Steward (Tang & Shin, 2024) shows the trend of language-model-driven automation frameworks, but our library focuses on controlled messaging platforms rather than broad web navigation.\s
        arXiv
        
        Regulatory, Ethical & Human-Centric Automation
        
        Automation on messaging platforms must navigate not only technical obstacles but also policy and data-protection regulations. The literature emphasises the “ironies of automation” (Bainbridge 1983): increased automation may strain human oversight and introduce new risks.\s
        Wikipedia
         In the context of WhatsApp and Meta platforms, compliance with platform Terms of Service, Business Policy, and data-protection laws (GDPR, DPDPA) is mandatory. Many existing automation studies neglect these compliance layers. Our framework deliberately embeds ethics and regulation upfront, ensuring automation remains within policy bounds and protects user privacy.
        
        Subtle questions for deeper coverage:
        
        Would you like additional coverage of fingerprint/fingerprint‐resistance techniques in automation tool design (e.g., device/browser fingerprint rotation, stealth context, bot-detection evasion research)?
        
        Should the review include AI-augmented automation and anti-automation detection techniques (e.g., models that detect automation in messaging apps) so we can cite existing detection/defense literature?
""";

    int cnt (String s ){
        return s.split(" ").length;
    }

    public static void main(String[] args) {
        count c = new count();
        System.out.println(c.cnt(c.str));
    }
}

