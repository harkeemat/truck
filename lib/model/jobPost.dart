class JobPost {
  final String user_id;
  final String order_number;
  final String driver_id;
  final String vehicle_type;
  final String container_type;
  final String weight;
  final String DIM;
  final String pickup_location;
  final String pickdate;
  final String drop_location;
  final String dropdate;
  final String distance;

  JobPost(
      {this.user_id,
      this.order_number,
      this.driver_id,
      this.vehicle_type,
      this.container_type,
      this.weight,
      this.DIM,
      this.pickup_location,
      this.pickdate,
      this.drop_location,
      this.dropdate,
      this.distance});

  factory JobPost.fromJson(Map<String, dynamic> JobPostjson) => JobPost(
        user_id: JobPostjson["user_id"],
        order_number: JobPostjson["order_number"],
        driver_id: JobPostjson["driver_id"],
        vehicle_type: JobPostjson["vehicle_type"],
        container_type: JobPostjson["container_type"],
        weight: JobPostjson["weight"],
        DIM: JobPostjson["DIM"],
        pickup_location: JobPostjson["pickup_location"],
        pickdate: JobPostjson["pickdate"],
        drop_location: JobPostjson["drop_location"],
        dropdate: JobPostjson["dropdate"],
        distance: JobPostjson["distance"],
      );
}
