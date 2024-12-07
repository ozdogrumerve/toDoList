import Array "mo:base/Array";

actor TodoList {
    // Görevlerin tutulacağı dizi
    private var tasks : [Task] = [];

    type Task = {
          id: Nat;
          title: Text;
          description: Text;
          completed: Bool;
    };

    // Görev ekleme fonksiyonu
    public func addTask(title: Text, description: Text) : async Nat {
        let id = Array.size(tasks) + 1; // Yeni ID atama
        let newTask : Task = { id = id; title = title; description = description; completed = false }; // Yeni görev oluşturma
        tasks := Array.append(tasks, [newTask]);

        return id; // Yeni görev ID'sini döndürme
    };

    // Görev listesini getirme fonksiyonu
    public func listTasks() : async [Task] {
        return tasks; // Tüm görevleri döndür
    };

    // Görev durumunu güncelleme fonksiyonu
    public func updateTask(id: Nat) : async Bool {
        // Görevi bulmak için Array.map kullanıyoruz
        tasks := Array.map(tasks, func(task: Task) : Task {
            if (task.id == id) {
                return { task with completed = true }; // Belirtilen id'ye sahip olan görevi tamamlanmış yap
            };
            return task; // Diğer görevleri olduğu gibi bırak
        });
        return true; // İşlem başarılı
    };

    // Görev silme fonksiyonu
    public func deleteTask(id: Nat) : async Bool {
        let initialLength = Array.size(tasks); // Başlangıçta dizinin boyutunu al
        tasks := Array.filter(tasks, func(task: Task) : Bool {
            return task.id != id; // ID'si eşleşmeyen görevleri tut
        });
        let newLength = Array.size(tasks); // Yeni dizinin boyutunu al
        return newLength < initialLength; // Görev silindiyse true döndür
    };
}

