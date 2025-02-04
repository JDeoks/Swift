class OfflineDefect: Object {
    @Persisted var id: String?
    @Persisted var site: String?
    @Persisted var building: String?
    @Persisted var unit: String?
    @Persisted var space: String?
    @Persisted var part: String?
    @Persisted var workType: String?
    @Persisted var beforeDescription: String?
    @Persisted var requesterID: String?
    @Persisted var requesterName: String?
    @Persisted var requesterPhone: String?
    @Persisted var teamID: String?
    @Persisted var creationTime: Date?
    
    // Core Data에서는 toMany 관계를 직접 설정했지만, Realm에서는 List<> 사용
    @Persisted var beforeImages = List<OfflineImage>()
}