# 🎨 ROADMAP DE IMPLEMENTAÇÃO - UI/UX TRANSFORMATION
## OpenNutriTracker → Nível YAZIO

**Duração Total:** 8 semanas
**Status:** 📋 Planejamento
**Última Atualização:** 2025-11-10

---

## 📊 OVERVIEW DO PROJETO

### Objetivo
Transformar o OpenNutriTracker em um concorrente visual do YAZIO, mantendo a filosofia privacy-first e melhorando a experiência do usuário.

### Métricas de Sucesso
- [ ] Visual Appeal: 4/10 → 9/10
- [ ] Logging Speed: 8 taps → 3 taps
- [ ] User Engagement: +40%
- [ ] D7 Retention: +20%
- [ ] D30 Retention: +35%

---

## 🏗️ FASE 1: VISUAL REFRESH (Semanas 1-2)
**Status:** ⏳ Não Iniciado
**Objetivo:** Transformar aparência sem mudar funcionalidades

### Week 1: Design System Foundation

#### Task 1.1: Setup Design Tokens
- [ ] Criar `lib/core/styles/design_tokens.dart`
  - [ ] Definir spacing scale (4, 8, 12, 16, 24, 32, 48dp)
  - [ ] Definir radius scale (8, 12, 16, 24dp)
  - [ ] Definir elevation scale (2, 4, 8dp)
  - [ ] Definir animation durations (200ms, 300ms, 500ms)
  - [ ] Documentar usage guidelines

#### Task 1.2: Color System Enhancement
- [ ] Atualizar `lib/core/styles/color_schemes.dart`
  - [ ] Adicionar macro colors (Protein=#4A90E2, Carbs=#F5A623, Fat=#FFC107)
  - [ ] Definir gradient definitions
  - [ ] Adicionar semantic colors (success, warning, error)
  - [ ] Criar colored shadow utilities

#### Task 1.3: Theme Factory
- [ ] Criar `lib/core/styles/app_theme.dart`
  - [ ] ThemeData factory para light mode
  - [ ] ThemeData factory para dark mode
  - [ ] Extension methods para Theme access
  - [ ] Custom TextTheme com Poppins weights

#### Task 1.4: Typography Enhancement
- [ ] Atualizar `lib/core/styles/fonts.dart`
  - [ ] Criar custom TextStyles com semantic naming
  - [ ] DisplayLarge para hero numbers (Poppins Bold 57sp)
  - [ ] HeadlineLarge para section titles (Poppins SemiBold 32sp)
  - [ ] TitleLarge para card headers (Poppins Medium 22sp)
  - [ ] Documentar hierarchy usage

### Week 2: Dashboard Modernization

#### Task 1.5: Enhanced Calorie Ring
- [ ] Criar `lib/core/widgets/charts/calorie_ring_chart.dart`
  - [ ] Aumentar radius (90px → 140px)
  - [ ] Implementar gradient (verde → amarelo → vermelho)
  - [ ] Adicionar inner shadow effect
  - [ ] Animated value transitions
  - [ ] Responsive sizing

#### Task 1.6: Macro Nutrient Visualization
- [ ] Criar `lib/core/widgets/charts/macro_indicators.dart`
  - [ ] Color-code por macro (blue/orange/yellow)
  - [ ] Mini circular indicators
  - [ ] Percentage labels com Poppins SemiBold
  - [ ] Tap to expand functionality (future)

#### Task 1.7: Modern Card Component
- [ ] Criar `lib/core/widgets/cards/modern_card.dart`
  - [ ] Dynamic elevation (1 → 3-4)
  - [ ] Colored shadows (10% opacity)
  - [ ] Border radius 16dp
  - [ ] Gradient overlay option
  - [ ] Glassmorphism variant

#### Task 1.8: Refactor Dashboard
- [ ] Atualizar `lib/features/home/home_page.dart`
  - [ ] Integrar novo CalorieRingChart
  - [ ] Aplicar ModernCard aos widgets
  - [ ] Aumentar font weights de números chave
  - [ ] Implementar spacing variável
  - [ ] Adicionar subtle gradients

#### Task 1.9: Card Updates Across App
- [ ] Atualizar `lib/core/widgets/intake_card.dart`
  - [ ] Aplicar new elevation system
  - [ ] Adicionar shadows
  - [ ] Melhorar image overlay contrast
- [ ] Atualizar `lib/core/widgets/activity_card.dart`
  - [ ] Modern card styling
  - [ ] Enhanced shadows

#### Task 1.10: Icon System
- [ ] Criar custom meal category icons
  - [ ] Breakfast: coffee icon
  - [ ] Lunch: bowl icon
  - [ ] Dinner: utensils icon
  - [ ] Snacks: apple icon
- [ ] Adicionar a `lib/core/presentation/widgets/`

---

## 🚀 FASE 2: UX OPTIMIZATION (Semanas 3-4)
**Status:** ⏳ Não Iniciado
**Objetivo:** Reduzir fricção no logging (8 → 3-4 taps)

### Week 3: Quick Actions Implementation

#### Task 2.1: Speed Dial FAB
- [ ] Criar `lib/core/widgets/misc/speed_dial_fab.dart`
  - [ ] Expandable FAB com 2 options (Meal, Activity)
  - [ ] Spring animation on expand
  - [ ] Backdrop dim on open
  - [ ] Integrar em `main_screen.dart`

#### Task 2.2: Quick Add Buttons
- [ ] Criar `lib/features/home/widgets/quick_add_button.dart`
  - [ ] Small button component
  - [ ] Icon + "Add" label
  - [ ] Integrar em cada meal section

#### Task 2.3: Log Again Feature
- [ ] Atualizar `lib/core/widgets/intake_card.dart`
  - [ ] Adicionar "Log Again" button
  - [ ] Icon button no corner
  - [ ] Duplicate meal logic
  - [ ] Success feedback animation

#### Task 2.4: Scanner Quick Access
- [ ] Atualizar navigation
  - [ ] Adicionar scanner ao speed dial OU
  - [ ] Floating scanner button on home
  - [ ] Refactor scanner access flow

### Week 4: Enhanced Interactions

#### Task 2.5: Modern Bottom Sheet
- [ ] Criar `lib/core/widgets/sheets/modern_bottom_sheet.dart`
  - [ ] Drag indicator visual
  - [ ] Snap points (25%, 50%, 100%)
  - [ ] Spring physics for drag
  - [ ] Blur backdrop (BackdropFilter)
  - [ ] Keyboard-aware sizing

#### Task 2.6: Refactor Add Meal Bottom Sheet
- [ ] Atualizar `lib/core/widgets/add_item_bottom_sheet.dart`
  - [ ] Usar ModernBottomSheet base
  - [ ] Melhorar layout
  - [ ] Animated transitions

#### Task 2.7: Collapsible Meal Sections
- [ ] Criar `lib/features/home/widgets/collapsible_meal_section.dart`
  - [ ] ExpansionTile customizado
  - [ ] Smooth expand/collapse animation
  - [ ] Persistent state (lembrar se expandido)
  - [ ] Empty state collapses by default

#### Task 2.8: Enhanced Search
- [ ] Atualizar `lib/features/add_meal/presentation/widgets/meal_search_bar.dart`
  - [ ] Floating search bar (sticky on scroll)
  - [ ] Remember last used tab
  - [ ] Clear button with animation
  - [ ] Search history (se viável)

#### Task 2.9: Swipe Actions
- [ ] Implementar swipe-to-delete
  - [ ] Usar `flutter_slidable` package
  - [ ] Custom delete background (red gradient)
  - [ ] Custom edit background (blue gradient)
  - [ ] Confirmation dialog animado

#### Task 2.10: Pull to Refresh
- [ ] Adicionar em Home e Diary
  - [ ] Custom refresh indicator com branding
  - [ ] ONT logo animation
  - [ ] Haptic feedback on trigger

---

## ✨ FASE 3: ANIMATIONS & DELIGHT (Semanas 5-6)
**Status:** ⏳ Não Iniciado
**Objetivo:** Adicionar camada de polish premium

### Week 5: Core Animations

#### Task 3.1: Dependencies Setup
- [ ] Adicionar ao `pubspec.yaml`:
  ```yaml
  flutter_staggered_animations: ^1.1.1
  shimmer: ^3.0.0
  confetti: ^0.7.0
  ```
- [ ] Run `flutter pub get`
- [ ] Run `flutter pub run build_runner build`

#### Task 3.2: Hero Animations
- [ ] Implementar Hero transition meal card → detail
  - [ ] Tag: 'meal-${intake.id}'
  - [ ] Smooth image transition
  - [ ] Atualizar `intake_card.dart`
  - [ ] Atualizar `meal_detail_screen.dart`
- [ ] Implementar Hero transition activity card → detail
  - [ ] Mesma abordagem

#### Task 3.3: Page Transitions
- [ ] Criar `lib/core/animations/page_transitions.dart`
  - [ ] SharedAxisPageRoute
  - [ ] FadeThroughPageRoute
  - [ ] Custom curves
- [ ] Aplicar em principais navigations

#### Task 3.4: Staggered List Animations
- [ ] Atualizar listas de meals
  - [ ] AnimationConfiguration.staggeredList
  - [ ] SlideAnimation + FadeInAnimation
  - [ ] 50ms delay entre items
- [ ] Aplicar em diary list
- [ ] Aplicar em search results

#### Task 3.5: Micro-interactions Library
- [ ] Criar `lib/core/animations/micro_interactions.dart`
  - [ ] ScaleAnimation for buttons
  - [ ] PulseAnimation for achievements
  - [ ] ShakeAnimation for errors
  - [ ] BounceAnimation for success

### Week 6: Loading States & Celebrations

#### Task 3.6: Shimmer Loading
- [ ] Criar `lib/core/widgets/cards/shimmer_card.dart`
  - [ ] Meal card skeleton
  - [ ] Activity card skeleton
  - [ ] Dashboard skeleton
- [ ] Implementar em todos os loading states
  - [ ] Home page initial load
  - [ ] Diary page load
  - [ ] Search results load

#### Task 3.7: Progressive Image Loading
- [ ] Atualizar CachedNetworkImage usage
  - [ ] BlurHash placeholders
  - [ ] Fade-in animation (300ms)
  - [ ] Error state com icon
  - [ ] Retry on error

#### Task 3.8: Success Animations
- [ ] Criar `lib/core/animations/celebration_animations.dart`
  - [ ] Checkmark animation (Lottie ou custom)
  - [ ] Confetti for 100% goal
  - [ ] Pulse animation for milestone
- [ ] Integrar em add meal success
- [ ] Integrar em goal achievement

#### Task 3.9: Haptic Feedback
- [ ] Adicionar HapticFeedback calls
  - [ ] Light impact on button press
  - [ ] Medium impact on success
  - [ ] Heavy impact on achievement
  - [ ] Selection feedback on swipe

#### Task 3.10: Button Animations
- [ ] Atualizar todos os buttons
  - [ ] Scale down on press (0.98)
  - [ ] Spring back on release
  - [ ] Ripple color customization
  - [ ] Loading state with spinner

---

## 📊 FASE 4: DATA VIZ & INSIGHTS (Semanas 7-8)
**Status:** ⏳ Não Iniciado
**Objetivo:** Transformar dados em insights visuais

### Week 7: Charts Implementation

#### Task 4.1: Dependencies Setup
- [ ] Adicionar ao `pubspec.yaml`:
  ```yaml
  fl_chart: ^0.69.0
  lottie: ^3.0.0  # Opcional
  ```
- [ ] Run `flutter pub get`

#### Task 4.2: Weekly Trend Chart
- [ ] Criar `lib/core/widgets/charts/weekly_trend_chart.dart`
  - [ ] LineChart with fl_chart
  - [ ] 7-day calorie data
  - [ ] Gradient fill under line
  - [ ] Touch tooltips
  - [ ] Animated drawing

#### Task 4.3: Macro Donut Chart
- [ ] Criar `lib/core/widgets/charts/macro_donut_chart.dart`
  - [ ] PieChart with fl_chart
  - [ ] Color-coded segments (protein/carbs/fat)
  - [ ] Center text overlay (total kcal)
  - [ ] Touch interactions
  - [ ] Animated segments

#### Task 4.4: Sparklines
- [ ] Criar `lib/core/widgets/charts/sparkline.dart`
  - [ ] Mini line chart component
  - [ ] 7-day mini trend
  - [ ] No axes, just line
  - [ ] Reusable component

#### Task 4.5: Weight Progress Chart
- [ ] Criar `lib/core/widgets/charts/weight_progress_chart.dart`
  - [ ] LineChart with weight over time
  - [ ] Goal line indicator
  - [ ] Trend projection (optional)
  - [ ] Integrar em Profile page

### Week 8: Insights & Gamification

#### Task 4.6: Insights Feature
- [ ] Criar `lib/features/insights/` structure
  - [ ] presentation/insights_page.dart
  - [ ] presentation/bloc/ (se necessário)
  - [ ] presentation/widgets/
- [ ] Adicionar tab "Insights" OU integrar com Diary

#### Task 4.7: Streak Tracking
- [ ] Criar `lib/core/widgets/misc/streak_badge.dart`
  - [ ] Fire icon with count
  - [ ] Animated flame
  - [ ] Tap to view details
- [ ] Implementar streak logic
  - [ ] Calculate consecutive days
  - [ ] Store in Hive
  - [ ] Reset logic
- [ ] Adicionar ao topo do dashboard

#### Task 4.8: Achievement System
- [ ] Criar `lib/features/insights/widgets/achievement_card.dart`
  - [ ] Badge icon
  - [ ] Achievement title
  - [ ] Progress indicator
  - [ ] Unlock animation
- [ ] Define achievements:
  - [ ] 7-day streak
  - [ ] 30-day streak
  - [ ] 100 meals logged
  - [ ] Goal achieved 7 days
  - [ ] Perfect macro day
- [ ] Store achievement state in Hive

#### Task 4.9: Enhanced Diary Visualizations
- [ ] Atualizar `lib/features/diary/diary_page.dart`
  - [ ] Adicionar weekly summary card
  - [ ] Heatmap calendar (streak visualization)
  - [ ] Comparison view toggle
  - [ ] Pattern insights widget

#### Task 4.10: Empty State Illustrations
- [ ] Criar `lib/core/widgets/misc/empty_state.dart`
  - [ ] Lottie animation OU custom illustration
  - [ ] Title + description
  - [ ] CTA button
- [ ] Aplicar em:
  - [ ] Empty meal sections
  - [ ] No search results
  - [ ] Empty diary day
  - [ ] No activities

---

## 🎨 DESIGN SYSTEM DOCUMENTATION

### Task DS.1: Component Documentation
- [ ] Criar `docs/DESIGN_SYSTEM.md`
  - [ ] Color palette com hex codes
  - [ ] Typography scale
  - [ ] Spacing system
  - [ ] Component library reference
  - [ ] Animation guidelines
  - [ ] Usage examples

### Task DS.2: Storybook/Widgetbook (Optional)
- [ ] Setup Widgetbook package
- [ ] Create stories for:
  - [ ] ModernCard variants
  - [ ] Button states
  - [ ] Chart components
  - [ ] Loading states

---

## 🧪 TESTING & QA

### Task QA.1: Visual Regression Testing
- [ ] Setup golden tests
- [ ] Create golden files for:
  - [ ] Dashboard variations
  - [ ] Card components
  - [ ] Chart widgets
  - [ ] Empty states

### Task QA.2: Performance Testing
- [ ] Profile dashboard rendering
- [ ] Profile list scrolling performance
- [ ] Profile animation frame rate
- [ ] Ensure 60fps on all screens

### Task QA.3: Accessibility Audit
- [ ] Test with TalkBack (Android)
- [ ] Test with VoiceOver (iOS)
- [ ] Verify color contrast ratios
- [ ] Test touch target sizes (≥48x48dp)
- [ ] Verify semantic labels

### Task QA.4: Cross-Device Testing
- [ ] Test on Android (various screen sizes)
- [ ] Test on iOS (various screen sizes)
- [ ] Test dark mode
- [ ] Test light mode
- [ ] Test tablet layouts (future)

---

## 📝 DOCUMENTATION

### Task DOC.1: Update CLAUDE.md
- [ ] Add design system section
- [ ] Document new component structure
- [ ] Add animation guidelines
- [ ] Update development workflow

### Task DOC.2: Create CHANGELOG.md
- [ ] Document all UI/UX changes
- [ ] Version 2.0.0 release notes
- [ ] Migration guide (if breaking changes)

### Task DOC.3: Update README.md
- [ ] Add screenshots of new UI
- [ ] Update feature list
- [ ] Add design credits

---

## 🚀 DEPLOYMENT

### Task DEPLOY.1: Pre-Release Checklist
- [ ] All tests passing
- [ ] Performance benchmarks met
- [ ] Accessibility compliance verified
- [ ] Documentation complete
- [ ] Screenshots updated

### Task DEPLOY.2: Beta Testing
- [ ] Release beta build
- [ ] Gather user feedback
- [ ] Address critical issues
- [ ] Iterate on polish

### Task DEPLOY.3: Production Release
- [ ] Version bump (2.0.0)
- [ ] Update app store screenshots
- [ ] Write release notes
- [ ] Submit to stores

---

## 📊 PROGRESS TRACKING

### Overall Progress
- [ ] Fase 1: Visual Refresh (0/10 tasks)
- [ ] Fase 2: UX Optimization (0/10 tasks)
- [ ] Fase 3: Animations & Delight (0/10 tasks)
- [ ] Fase 4: Data Viz & Insights (0/10 tasks)
- [ ] Design System (0/2 tasks)
- [ ] Testing & QA (0/4 tasks)
- [ ] Documentation (0/3 tasks)
- [ ] Deployment (0/3 tasks)

**Total Tasks:** 42
**Completed:** 0
**In Progress:** 0
**Remaining:** 42

### Milestones
- [ ] **Milestone 1:** Design system completo (Week 1)
- [ ] **Milestone 2:** Dashboard redesenhado (Week 2)
- [ ] **Milestone 3:** Quick actions funcionais (Week 3)
- [ ] **Milestone 4:** Animações integradas (Week 6)
- [ ] **Milestone 5:** Charts implementados (Week 7)
- [ ] **Milestone 6:** Beta release (Week 8)

---

## 🔧 TECHNICAL DECISIONS LOG

### Decision 1: Chart Library
**Date:** TBD
**Decision:** fl_chart vs syncfusion vs custom
**Rationale:** TBD

### Decision 2: Illustration Approach
**Date:** TBD
**Decision:** Lottie animations vs SVG vs custom painter
**Rationale:** TBD

### Decision 3: Insights Tab Location
**Date:** TBD
**Decision:** New 4th tab vs integrated with Diary
**Rationale:** TBD

### Decision 4: Color Palette
**Date:** TBD
**Decision:** Keep green vs migrate to YAZIO-style teal/mint
**Rationale:** TBD

### Decision 5: Gamification Depth
**Date:** TBD
**Decision:** Visual only vs with rewards system
**Rationale:** TBD

---

## 📞 SUPPORT & RESOURCES

### Key Files to Reference
- `/lib/core/styles/color_schemes.dart` - Current colors
- `/lib/core/styles/fonts.dart` - Typography
- `/lib/features/home/home_page.dart` - Main dashboard
- `/lib/core/widgets/` - Existing components

### External Resources
- [Material Design 3 Guidelines](https://m3.material.io/)
- [Flutter Animation Docs](https://docs.flutter.dev/development/ui/animations)
- [fl_chart Documentation](https://pub.dev/packages/fl_chart)
- [YAZIO Design Reference](Research conducted)

### Community
- GitHub Issues: https://github.com/simonoppowa/OpenNutriTracker/issues
- Development Discussion: TBD

---

## 🎯 NOTES

- Manter philosophy privacy-first em todas as features
- Todas as animações devem ter opção de reduced motion
- Garantir acessibilidade em todas as mudanças visuais
- Documentar decisões importantes no log acima
- Performance é prioridade - 60fps sempre

**Last Updated:** 2025-11-10
**Next Review:** Após conclusão Fase 1
