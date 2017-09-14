<template>
  <div>
    <ul id="dropdown" class="dropdown-content">
      <li><a href="#">Top</a></li>
      <li><a href="#">About</a></li>
      <li><a href="#">Contact</a></li>
    </ul>
    <nav>
      <div class="nav-wrapper container">
        <a href="/" class="brand-logo left">Todo Application</a>
        <ul class="right hide-on-med-and-down">
          <li><a href="#">Top</a></li>
          <li><a href="#">About</a></li>
          <li><a href="#">Contact</a></li>
        </ul>
        <ul class="right hide-on-large-only">
          <li>
            <a class="dropdown-button" href="#!" data-activates="dropdown">
              Menu<i class="material-icons right">arrow_drop_down</i>
            </a>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>