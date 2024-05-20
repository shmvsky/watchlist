<template>
  <div class="vh-100 text-bg-light">
    <div class="h-100 container">
      <div id="app">
        <ul class="nav nav-tabs mb-3">
          <li class="nav-item">
            <router-link to="/add-movie" class="nav-link">ADD MOVIE</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/movies" class="nav-link">LIST MOVIES</router-link>
          </li>
        </ul>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: 'App'
};
</script>

<style>
</style>
